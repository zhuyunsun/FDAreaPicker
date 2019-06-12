# FDAreaPicker

### A pickerView for area.
show 
![image](https://20190422zy.oss-cn-shenzhen.aliyuncs.com/2019-4-24-01/%E8%87%AA%E5%AE%9A%E4%B9%89%E7%9A%84%E7%9C%81%E5%B8%82%E9%80%89%E6%8B%A9%E5%99%A8/area-show.gif)

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
