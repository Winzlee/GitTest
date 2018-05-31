//
//  TPKeyboardAvoidingTableView.h
//
//  Created by Michael Tyson on 11/04/2011.
//  Copyright 2011 A Tasty Pixel. All rights reserved.
//

@interface TPKeyboardAvoidingTableView : UITableView {
    
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    
    @public
    UIEdgeInsets    _priorInset;
}

- (void)adjustOffsetToIdealIfNeeded;
@end
