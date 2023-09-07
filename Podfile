platform :ios, '16.0'

target 'CatsApp' do

  use_frameworks!
  inhibit_all_warnings!

  # Pods for CatsApp
  pod 'SwiftLint'
  pod 'RealmSwift', '~>10'

  target 'CatsAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CatsAppUITests' do
    # Pods for testing
  end

end

post_install do |installer|

  installer.pods_project.targets.each do |target|
    if target.name == 'Realm'
      create_symlink_phase = target.shell_script_build_phases.find { |x| x.name == 'Create Symlinks to Header Folders' }
      create_symlink_phase.always_out_of_date = "1"
    end
  end

end
