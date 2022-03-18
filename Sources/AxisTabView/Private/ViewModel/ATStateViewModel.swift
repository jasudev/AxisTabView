//
//  ATStateViewModel.swift
//  AxisTabView
//
//  Created by jasu on 2022/03/07.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftUI

/// A viewmodel that manages the current and previous values of the selected tab.
class ATStateViewModel<SelectionValue: Hashable>: ObservableObject {
    
    /// The tag of the previously selected tab.
    var previousSelection: SelectionValue? = nil
    
    /// An array of all tags.
    var tags: [SelectionValue] = []
    
    /// The index value of the previously selected tag.
    var previousIndex: Int {
        return indexOfTag(previousSelection)
    }
    
    /// Returns the position index of the tag.
    /// - Parameter tag: A tag that separates the tab view.
    /// - Returns: Returns the position index of the tag.
    func indexOfTag(_ tag: SelectionValue?) -> Int {
        return tags.firstIndex(where: {$0 == tag}) ?? 0
    }
}
