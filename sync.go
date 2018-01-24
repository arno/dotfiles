package main

import (
	"bufio"
	"bytes"
	"crypto/md5"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

var excluded = map[string]struct{}{
	"README.md": {},
	"sync.go":   {},
	"sync.py":   {},
}

var install = flag.Bool("install", false, "install new or modified files without asking question")

func bold(s string) string {
	return "\033[1m" + s + "\033[0m"
}

func compareFiles(path1, path2 string) (bool, error) {
	md5s := [2][]byte{}

	for i, fn := range [2]string{path1, path2} {
		f, err := os.Open(fn)
		if err != nil {
			return false, fmt.Errorf("opening %s: %s", fn, err)
		}

		h := md5.New()
		if _, err := io.Copy(h, f); err != nil {
			return false, fmt.Errorf("hashing %s: %s", fn, err)
		}

		md5s[i] = h.Sum(nil)

		f.Close()
	}

	return bytes.Equal(md5s[0], md5s[1]), nil
}

func ask(text string) string {
	reader := bufio.NewReader(os.Stdin)
	fmt.Print(text)
	ans, _ := reader.ReadString('\n')
	return strings.TrimSpace(ans)
}

func copyFile(src, dst string) error {
	in, err := os.Open(src)
	if err != nil {
		return err
	}
	defer in.Close()

	out, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer func() {
		cerr := out.Close()
		if err == nil {
			err = cerr
		}
	}()

	if _, err = io.Copy(out, in); err != nil {
		return err
	}
	err = out.Sync()

	return err
}

func installFile(src, dst string) error {
	fmt.Printf("Installing %s => %s\n", src, dst)
	if err := os.MkdirAll(filepath.Dir(dst), 0755); err != nil {
		return err
	}
	return copyFile(src, dst)
}

func showDiff(src, dst string) {
	out, _ := exec.Command("diff", "-u", "--ignore-blank-lines", "--color=always", src, dst).Output()
	fmt.Printf("%s", out)
}

func installNewFile(src, dst string) error {
	fmt.Printf(bold("\n==> %s does not exist\n"), dst)

	if *install {
		return installFile(src, dst)
	}

	for {
		c := ask("Install current version? [Y|n|q] ")
		switch {
		case c == "", c == "y", c == "Y":
			return installFile(src, dst)
		case c == "n", c == "N":
			return nil
		case c == "q", c == "Q":
			os.Exit(0)
		}
	}
}

func handleDifferentFiles(src, dst string) error {
	fmt.Printf(bold("\n==> %s and %s are different\n"), src, dst)

	if *install {
		return installFile(src, dst)
	}

	for {
		fmt.Println("You can:")
		fmt.Println("    d) Show difference between files")
		fmt.Println("    i) Install version from this repository")
		fmt.Println("    k) Keep local version")
		fmt.Println("    u) Use local version and copy it in this repository")
		fmt.Println("    q) Quit")
		c := ask("Your choice: [d|i|K|u|q] ")
		switch {
		case c == "d", c == "D":
			showDiff(dst, src)
		case c == "i", c == "I":
			return installFile(src, dst)
		case c == "", c == "k", c == "K":
			return nil
		case c == "u", c == "U":
			return installFile(dst, src)
		case c == "q", c == "Q":
			os.Exit(0)
		}
	}
}

func analyzeFile(path string, info os.FileInfo, err error) error {
	switch {
	case info.IsDir() || path[0] == '.':
		return nil
	case err != nil:
		fmt.Printf("ERROR: reading %s: %s\n", path, err)
		return nil
	}

	if _, ok := excluded[filepath.Base(path)]; ok {
		return nil
	}

	realpath := filepath.Join(os.Getenv("HOME"), "."+path)
	if _, err := os.Stat(realpath); os.IsNotExist(err) {
		if err := installNewFile(path, realpath); err != nil {
			fmt.Printf("ERROR: %s\n", err)
		}
		return nil
	}

	same, err := compareFiles(path, realpath)
	switch {
	case err != nil:
		fmt.Printf("ERROR: %s", err)
		return nil
	case same:
		return nil
	}

	if err := handleDifferentFiles(path, realpath); err != nil {
		fmt.Printf("ERROR: %s\n", err)
	}

	return nil
}

func main() {
	flag.Parse()

	err := filepath.Walk(".", analyzeFile)
	if err != nil {
		log.Fatalf("ERROR: %s\n", err)
	}
}
