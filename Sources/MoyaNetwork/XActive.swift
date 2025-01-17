//
//  XActive.swift
//  RxNetworks
//
//  Created by Condy on 2023/6/28.
//

import Foundation
import Moya

// 模块宏定义

extension RxNetworks.X {
    
    /// 注入默认插件
    static func defaultPlugin(_ plugins: inout APIPlugins, api: NetworkAPI) {
        var plugins_ = plugins
        if let others = NetworkConfig.injectionPlugins {
            plugins_ += others
        }
        #if RxNetworks_MoyaPlugins_Indicator
        if NetworkConfig.addIndicator, !plugins_.contains(where: { $0 is NetworkIndicatorPlugin}) {
            let Indicator = NetworkIndicatorPlugin.shared
            plugins_.insert(Indicator, at: 0)
        }
        #endif
        #if DEBUG && RxNetworks_MoyaPlugins_Debugging
        if NetworkConfig.addDebugging, !plugins_.contains(where: { $0 is NetworkDebuggingPlugin}) {
            let Debugging = NetworkDebuggingPlugin.init()
            plugins_.append(Debugging)
        }
        #endif
        plugins = plugins_
    }
    
    /// 是否存在共享网络插件
    static func hasNetworkSharedPlugin(_ plugins: APIPlugins) -> Bool {
        #if RxNetworks_MoyaPlugins_Shared
        return plugins.contains(where: { $0 is NetworkSharedPlugin })
        #else
        return false
        #endif
    }
}
