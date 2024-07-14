//
//  Theme.swift
//  VisageVerify Background
//
//  Created by Nikita Ochkin on 14.07.2024.
//

import SwiftUI

struct Theme {
    // define background color
    static func generalBackground(forScheme scheme: ColorScheme) -> Color {
        let light = Color(red: 255/255, green: 252/255, blue: 242/255) // bone color
        let dark  = Color(red: 37/255,  green: 36/255,  blue: 34/255)  // blackish
        
        // choose bg based on a device theme
        switch scheme {
            case .light:
                return light
            case .dark:
                return dark
            @unknown default:
                return dark
        }
    }
    
    // define firefly color
    static func FireflyTheme(forScheme scheme: ColorScheme) -> Color {
        // used both in dark and light themes
        let orange = Color(red: 235/255, green: 94/255, blue: 40/255, opacity: 0.91) // orange color
        
        // colors for dark theme
        let bone      = Color(red: 255/255, green: 252/255, blue: 242/255) // bone color
        let dirtyBone = Color(red: 204/255, green: 197/255, blue: 185/255) // dirty bone color
        // let bone      = Color(.red)    // debug
        // let dirtyBone = Color(.purple) // debug
        
        // array with colors for dark theme (dots are light and bg is dark)
        // bone is: 3x as rare, dirty bone: 2x and orange: 1x
        let darkFireflyColors: [Color] = [bone, bone, bone, dirtyBone, dirtyBone, orange]
        
        // colors for light theme
        let grayish  = Color(red: 64/255, green: 61/255, blue: 57/255) // grayish
        let blackish = Color(red: 37/255, green: 36/255, blue: 34/255) // blackish
        // let grayish  = Color(.green)  // debug
        // let blackish = Color(.yellow) // debug
        
        // array with colors for light theme (dots are dark and bg is light)
        // blackish is: 3x as rare, grayish: 2x and orange: 1x
        let lightFireflyColors: [Color] = [blackish, blackish, blackish, grayish, grayish, orange]
        
        // choose a firefly color based on a device theme
        switch scheme {
            case .light:
                let colorForLightTheme = lightFireflyColors.randomElement()!
                // let _ = print("chosen color for light theme: \(colorForLightTheme)")
                return colorForLightTheme
            
            case .dark:
                let colorForDarkTheme = darkFireflyColors.randomElement()!
                // let _ = print("chosen color for dark theme: \(colorForDarkTheme)")
                return colorForDarkTheme
            
            @unknown default:
                return darkFireflyColors.randomElement()!
        }
    }
    
    // define shadow color
    static func shadowTheme(forScheme scheme: ColorScheme) -> Color {
        let light = Color(red: 255/255, green: 252/255, blue: 242/255) // bone color
        let dark  = Color(red: 37/255,  green: 36/255,  blue: 34/255)  // blackish
        
        // choose bg based on a device theme
        switch scheme {
            case .light:
                return dark
            case .dark:
                return light
            @unknown default:
                return light
        }
    }
}
