# FDAreaPicker

### A pickerView for area.
show 
![image](https://20190422zy.oss-cn-shenzhen.aliyuncs.com/2019-4-24-01/area-show.gif)

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
