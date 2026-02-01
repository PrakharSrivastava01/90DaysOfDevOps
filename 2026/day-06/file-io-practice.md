What We Did
Practiced basic Linux text file operations using fundamental commands.

## Commands Used
```bash
touch notes.txt                                          # Created empty file
echo "Line 1" > notes.txt                                # Wrote first line (overwrite)
echo "Line 2" >> notes.txt                               # Appended second line
echo "Line 3" | tee -a notes.txt                         # Appended + displayed
cat notes.txt                                            # Read entire file
head -n 2 notes.txt                                      # Read first 2 lines
tail -n 2 notes.txt                                      # Read last 2 lines
```

## Key Concepts
- **`>`** = overwrite file
- **`>>`** = append to file
- **`tee -a`** = append + show on screen
- **`cat`** = display full file
- **`head`** = show top lines
- **`tail`** = show bottom lines

## Files Created
✓ notes.txt (practice file with 3 lines)
✓ file-io-practice.md (detailed documentation)
