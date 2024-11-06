


@Component
export struct MyTabsComp {

  build() {
    Column(){
      Text("暂未登录")
        .fontSize(24)
        .padding({bottom:10})
      Blank()
      Button("华为账号登录")
        .type(ButtonType.Capsule)
    }
  }

}
