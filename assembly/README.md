# Assembly Calculator Projects

This directory contains two implementations of a calculator using assembly language:

## 1. C with Inline x86-64 Assembly (`calc_asm.c`)

**Recommended for most users** - Combines C with x86-64 inline assembly for better readability and cross-platform support.

### How to Compile and Run:

**Linux/Mac:**
```bash
gcc -o calc_asm calc_asm.c
./calc_asm
```

**Windows (with WSL or MinGW):**
```bash
gcc -o calc_asm calc_asm.c
./calc_asm
```

### Example Usage:
```
Enter first number: 10
Enter operator (+, -, *, /): +
Enter second number: 5
Result: 15
```

## 2. Pure x86-64 Assembly (`calculator.s`)

**Advanced** - Pure assembly implementation for learning low-level CPU operations.

### How to Compile and Run (Linux only):

```bash
as -o calculator.o calculator.s
ld -o calculator calculator.o
./calculator
```

## Running on VS Code

### Prerequisites:
- **GCC/Clang compiler** (for C with inline assembly)
- **GNU Binutils** (for pure assembly)

### Setup Instructions:

#### Option 1: Use VS Code Terminal (Easiest)

1. Open VS Code and navigate to the `assembly` folder
2. Open the integrated terminal (Ctrl + ` on Windows/Linux, Cmd + ` on Mac)
3. Run the commands above

#### Option 2: Configure VS Code for Easy Compilation

Create `.vscode/tasks.json` in your project root:

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Compile C with Inline Assembly",
            "type": "shell",
            "command": "gcc",
            "args": ["-o", "${workspaceFolder}/assembly/calc_asm", "${workspaceFolder}/assembly/calc_asm.c"],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "problemMatcher": ["$gcc"]
        },
        {
            "label": "Run Assembly Calculator",
            "type": "shell",
            "command": "${workspaceFolder}/assembly/calc_asm",
            "dependsOn": ["Compile C with Inline Assembly"],
            "group": {
                "kind": "test",
                "isDefault": true
            }
        }
    ]
}
```

Then press `Ctrl+Shift+B` to compile and run.

## System Requirements

### Windows Users:
- **WSL 2** (Windows Subsystem for Linux) - Recommended
- **MinGW** - Alternative option
- **MSVC** - Not recommended for pure assembly

### Mac Users:
- macOS includes GCC/Clang by default
- Run `xcode-select --install` if not present

### Linux Users:
- Most distributions include GCC/Clang by default
- Install with: `sudo apt-get install build-essential` (Ubuntu/Debian)

## Supported Operators

- `+` - Addition
- `-` - Subtraction
- `*` - Multiplication
- `/` - Division (with zero-check in C version)

## Learning Resources

- **x86-64 Assembly:** https://en.wikibooks.org/wiki/X86_Assembly
- **Inline Assembly in GCC:** https://gcc.gnu.org/onlinedocs/gcc/Using-Inline-Assembly-with-C-Code.html
- **System V AMD64 ABI:** https://en.wikipedia.org/wiki/X86_calling_conventions
