if ARGV.empty?
  	print("❌ syntax had to be 'ruby update_version.rb version\n'")
  	exit
end

$new_version = ARGV[0]

def update_version(filePath, line_start, line_end)
	file_data = File.open(filePath).readlines.map(&:chomp)
	
	File.open(filePath, "w") { |file|
	file_data.each { |line|
		edited_line = line

		if line.include? line_start
			edited_line = "#{line_start}#{$new_version}#{line_end}"
		end

		file.write "#{edited_line}\n"
	}
}
end



print("• updating podspec file\n")

podspec_version_line_start = "  s.version          = '"
podspec_version_line_end = "'"

update_version('AnyFormatKit.podspec', podspec_version_line_start, podspec_version_line_end)


print("• updating README file\n")

spm_package_line_start = '    .package(url: "https://github.com/luximetr/AnyFormatKit.git", .upToNextMajor(from: "'
spm_package_line_end = '"))'

pod_line_start = "pod 'AnyFormatKit', '~> "
pod_line_end = "'"

update_version('README.md', spm_package_line_start, spm_package_line_end)
update_version('README.md', pod_line_start, pod_line_end)


print("• updating xcodeproj file\n")

xproj_version_line_start = "				MARKETING_VERSION = "
xproj_version_line_end = ";"

update_version('AnyFormatKit.xcodeproj/project.pbxproj', xproj_version_line_start, xproj_version_line_end)

print "✅ done\n"



