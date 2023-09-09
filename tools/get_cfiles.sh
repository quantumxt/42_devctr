c_files=""
output_path="cfile_list.txt"
file_found=$(find . -iname "*.c")

echo -e "\n=== get_cfiles ===\n" 
echo -e "C Files: $(echo "$file_found" | wc -l)" 

for i in $(echo "$file_found" | sort)
do
    c_files="${c_files} ${i:2}"
done

echo -e "Results:\n${c_files}\n"
echo ${c_files} > ${output_path}
echo -e "C filename(s) saved to: $(pwd)/${output_path}" 