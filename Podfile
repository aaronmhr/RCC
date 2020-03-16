platform :ios, '12.0'

# TESTING PODS
def testing_pods
    pod 'Quick', '2.2.0'
    pod 'Nimble', '8.0.4'
end


target 'RCC' do
  use_frameworks!

  target 'RCCTests' do
    inherit! :search_paths
  end
end

target 'Data' do
  use_frameworks!

  target 'DataTests' do
    inherit! :search_paths
    testing_pods
  end
end

target 'Presentation' do
  use_frameworks!

  target 'PresentationTests' do
    inherit! :search_paths
  end
end

target 'Converter' do
  use_frameworks!

  target 'ConverterTests' do
    inherit! :search_paths
  end
end
