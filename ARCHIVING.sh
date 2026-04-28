#!/bin/bash
#project made by silent_reaper or sheild techo
# --- Main Menu Functions ---

main_menu() {
  while true; do
    echo "--- LINUX ARCHIVE & COMPRESSION TOOL ---"
    echo "1. Archiving Menu (Compress)"
    echo "2. Decompression & Extraction Menu"
    echo "3. System Tools (File Check/Performance)"
    echo "4. Exit"
    read -p "Choose: " choose
    case $choose in
      1) menu ;;
      2) comp_menu ;;
      3) tools_menu ;;
      4) exit 0 ;;
      *) echo "Please enter a valid option." ;;
    esac
  done
}

# --- Archiving/Compression Menus ---

menu() {
  while true; do
    echo ""
    echo "--- ARCHIVING (COMPRESSION) ---"
    echo "1. Lite Archive (.gz) - Fast"
    echo "2. Medium Archive (.bz2) - Balanced"
    echo "3. Deep Archive (.xz) - Maximum"
    echo "4. Bulk Archive All Folders (.tar.xz)"
    echo "0. Return"
    read -p "Choose: " choose
    case $choose in
      1) lite_arch ;;
      2) med_archive ;;
      3) deep_arch ;;
      4) 
        read -p "Enter name for the bulk archive (without extension): " bulk_name
        # Documentation: tar -cJvf all_folders.tar.xz */
        tar -cJvf "${bulk_name}.tar.xz" */
        echo "Finished bulk archiving." ;;
      0) return ;;
      *) echo "Enter a valid option" ;;
    esac
  done
}

lite_arch() {
  while true; do
    echo ""
    echo "-- GZIP COMPRESSION --"
    echo "1. Archive Folder (.tar.gz)"
    echo "2. Archive File (.gz)"
    echo "0. Return"
    read -p "Choose: " choose
    case $choose in
      1)
        read -p "Choose folder to archive: " folder_arch
        read -p "Enter new archive name: " new_arch
        if [ -d "$folder_arch" ]; then
          sudo tar -czf "${new_arch}.tar.gz" "$folder_arch"
          echo "Created ${new_arch}.tar.gz"
        else
          echo "Folder not found: $folder_arch"
        fi ;;
      2)
        read -p "Choose file to archive: " file_arch
        read -p "Enter new file name: " file_arch_new
        if [ -f "$file_arch" ]; then
          gzip -c "$file_arch" > "${file_arch_new}.gz"
          echo "Created ${file_arch_new}.gz"
        else
          echo "File not found: $file_arch"
        fi ;;
      0) return ;;
    esac
  done
}

med_archive() {
  while true; do
    echo ""
    echo "-- BZIP2 COMPRESSION --"
    echo "1. Archive Folder (.tar.bz2)"
    echo "2. Archive File (.bz2)"
    echo "0. Return"
    read -p "Choose: " choose
    case $choose in
      1)
        read -p "Folder to archive: " folder_arch
        read -p "New archive name: " new_arch
        if [ -d "$folder_arch" ]; then
          sudo tar -cjf "${new_arch}.tar.bz2" "$folder_arch"
          echo "Created ${new_arch}.tar.bz2"
        fi ;;
      2)
        read -p "File to archive: " file_arch
        read -p "New file name: " file_arch_new
        if [ -f "$file_arch" ]; then
          bzip2 -c "$file_arch" > "${file_arch_new}.bz2"
          echo "Created ${file_arch_new}.bz2"
        fi ;;
      0) return ;;
    esac
  done
}

deep_arch() {
  while true; do
    echo ""
    echo "-- XZ COMPRESSION (Deep) --"
    echo "1. Archive Folder (.tar.xz)"
    echo "2. Archive File (.xz)"
    echo "0. Return"
    read -p "Choose: " choose
    case $choose in
      1)
        read -p "Folder to archive: " folder_arch
        read -p "New archive name: " new_arch
        if [ -d "$folder_arch" ]; then
          sudo tar -cJf "${new_arch}.tar.xz" "$folder_arch"
          echo "Created ${new_arch}.tar.xz"
        fi ;;
      2)
        read -p "File to archive: " file_arch
        read -p "New file name: " file_arch_new
        if [ -f "$file_arch" ]; then
          xz -c "$file_arch" > "${file_arch_new}.xz"
          echo "Created ${file_arch_new}.xz"
        fi ;;
      0) return ;;
    esac
  done
}

# --- Decompression & Tools ---

comp_menu() {
  while true; do
    echo ""
    echo "--- DECOMPRESSION & EXTRACTION ---"
    echo "1. Extract Tar Archive (.tar.gz, .tar.bz2, .tar.xz)"
    echo "2. Decompress single file (gunzip/bunzip2/unxz)"
    echo "0. Return"
    read -p "Choose: " choose
    case $choose in
      1)
        read -p "Path to archive: " t_file
        if [ -f "$t_file" ]; then
          # tar -xf handles different formats automatically
          tar -xvf "$t_file"
          echo "Extraction complete."
        else
          echo "Archive not found."
        fi ;;
      2)
        read -p "File to decompress: " d_file
        if [ -f "$d_file" ]; then
          case "$d_file" in
            *.gz) gunzip "$d_file" ;;
            *.bz2) bunzip2 "$d_file" ;;
            *.xz) unxz "$d_file" ;;
            *) echo "Unsupported single file format." ;;
          esac
          echo "Decompression finished."
        fi ;;
      0) return ;;
    esac
  done
}

tools_menu() {
  while true; do
    echo ""
    echo "--- SYSTEM TOOLS ---"
    echo "1. Check File Type (file)"
    echo "2. Measure Compression Performance (time)"
    echo "0. Return"
    read -p "Choose: " choose
    case $choose in
      1)
        read -p "Enter filename: " f_name
        file "$f_name" ;;
      2)
        read -p "Choose file/folder to measure (e.g., test.txt): " p_file
        read -p "Choose algorithm (gzip/bzip2/xz): " algo
        echo "Measuring time..."
        case $algo in
          gzip) time gzip -c "$p_file" > /dev/null ;;
          bzip2) time bzip2 -c "$p_file" > /dev/null ;;
          xz) time xz -c "$p_file" > /dev/null ;;
        esac ;;
      0) return ;;
    esac
  done
}

# Execute main menu
main_menu
