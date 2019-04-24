# FDAreaPicker

### A pickerView for area.
show 
![image](https://20190422zy.oss-cn-shenzhen.aliyuncs.com/2019-4-24-01/area-show.gif?Expires=1556093037&OSSAccessKeyId=TMP.AgGcYoxX6jm8u_pJ0e7SVkKfHrZ5fgBIW9rAKBzIir6OKmxyoHPyH3eD2yMSADAtAhUAqpCFX8h4cYcB8X8pGXGna9INF-4CFFyUWu051zkAytuPbWl5oj2fPVkz&Signature=LnApYDhnFwT2hRGh6XAqC%2BXNR9Q%3D)

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
