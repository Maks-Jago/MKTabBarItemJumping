//
//  LogoView.swift
//  MKTabBarItemJumping
//
//  Created by Max Kuznetsov on 27.10.2019.
//  Copyright © 2019 Max Kuznetsov. All rights reserved.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 74)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            LogoView()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
