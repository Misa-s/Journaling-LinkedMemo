# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

plugin 'cocoapods-binary'
use_frameworks!
all_binary!

target 'Journaling-LinkedMemo' do
  
 # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Journaling-LinkedMemo
  pod 'FontAwesome.swift'
  pod 'DKImagePickerController'
  pod 'GrowingTextView', '0.7.2'

  target 'Journaling-LinkedMemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Journaling-LinkedMemoUITests' do
    # Pods for testing
  end

end

# cocoa-pods-binaryの不具合暫定対応
def patch_cocoapods_binary_dsyms(installer)
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.shell_script_build_phases.each do |phase|
        
        shell_file = phase.shell_script.strip.gsub!(/\A"|"\Z/, '').delete_prefix "${PODS_ROOT}"
        shell_file = File.join("./Pods", shell_file)
        
        shell_script = File.read(shell_file, chomp: true)
        fixed_shell_script = shell_script.gsub("\"${DERIVED_FILES_DIR}\"", "\"${DERIVED_FILES_DIR}/\"")

        File.open(shell_file, "w") do |f|
          f.write(fixed_shell_script)
        end
        
        phase.input_file_list_paths.each do |file_list_path|
          dedupe_file_list(file_list_path)
        end
        
        phase.output_file_list_paths.each do |file_list_path|
          dedupe_file_list(file_list_path)
        end
      end
    end
  end
end

def dedupe_file_list(file_list_path)
  file_list_path = file_list_path.delete_prefix "${PODS_ROOT}"
  file_list_path = File.join("./Pods", file_list_path)
  
  contents = File.readlines(file_list_path, chomp: true)
  contents = contents.uniq
  File.open(file_list_path, "w") do |file|
    file.puts contents
  end
end

post_integrate do |installer|
  patch_cocoapods_binary_dsyms(installer)
end