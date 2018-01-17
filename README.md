# FDAreaPicker

### A pickerView for area.
show 
![image](http://oodrfzkav.bkt.clouddn.com/area/area-show.gif)

### How to use

Init

```
    _areaPicker = [[FDAreaPicker alloc]init];
    _areaPicker.delegate = self;

```
show

```
[_areaPicker showAreaView];

```

delegate

```
#pragma mark -- ======== delegate =========
-(void)cancelAction{
    NSLog(@"cancel");
}
-(void)selectArea:(NSString *)area{
    _selectLabel.text = area;
}
```
end
