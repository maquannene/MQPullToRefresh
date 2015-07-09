Pod::Spec.new do |s|

s.name         = "MQPushToRefresh"
s.version      = "0.0.1"
s.summary      = "下拉刷新 可自定义 正常，将要刷新，正在刷新，刷新成功，刷新失败五个状态的视图"

s.homepage     = 'https://github.com/wuhanness/MQPullToRefresh'

s.author       = { "maquan" => "maquan@kingsoft.com" }

s.platform     = :ios
s.platform     = :ios, "7.0"

s.source = { :git => 'https://github.com/wuhanness/MQPullToRefresh.git', :commit => '4bb46af00896d894a4959d7a5956f2fda7312607'}

s.source_files  = "MQPullToRefreshDemo/MQPushToRefresh/*.{h,m}"

s.framework  = "UIKit"
s.requires_arc = false

end
