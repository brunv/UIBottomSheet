# UIBottomSheet

_This is not a library!_

This is a simple project to have a starter code to implement a custom bottom sheet and its transition animation. `BottomSheetViewController` and `BottomSheetPresentationController` are the only files that matter. Take a look at the example in the section below.

## Usage

Example on how to use `BottomSheetViewController` and its custom transition with `BottomSheetPresentationController`:
```swift
  let bottomSheetVC = BottomSheetViewController()
  // You can expose any property in BottomSheetViewController and set it in here.
  // bottomSheetVC.sheetHeight = 400
  // bottomSheetVC.sheetBackgroundColor = .white
  // bottomSheetVC.sheetCornerRadius = 22

  bottomSheetVC.modalPresentationStyle = .custom
  bottomSheetVC.transitioningDelegate = self

  self.present(bottomSheetVC, animated: true)
```
