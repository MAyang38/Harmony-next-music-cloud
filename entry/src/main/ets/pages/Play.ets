import { songs } from '../constant/music'
import { AVPlayerClass } from '../utils/AVPlayerClass'
import { emitter } from '@kit.BasicServicesKit'
import { PlayState } from '../model/music'

@Entry
@Component
struct Play {

  @State playState:PlayState = {} as PlayState
  aboutToAppear(): void {
    this.playState.isPlay = false
    emitter.on({
      eventId:0
    },(data)=>{
      console.log(JSON.stringify(data.data))
      this.playState = data.data as PlayState
      // data.data
    })
  }
  number2time(number:number){
    // '00:00'
    const second = Math.floor(number/1000)
    if(second >=60){
      const m = Math.floor(second/60)
      return `${m.toString().padStart(2,'0')}:${second%60}`
    }else{
      return `00:${second.toString().padStart(2,'0')}`
    }
  }
  build() {
    // 播放
    Column() {
      // 图片
      Stack({ alignContent: Alignment.Top }) {
        Row() {
          Row() {
            Image(this.playState.img)
              .width('70%')
              .borderRadius(400)
          }
          .backgroundImage($r('app.media.ic_cd'))
          .backgroundImageSize(ImageSize.Cover)
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .borderRadius(400)
          .clip(true)
          .aspectRatio(1)
        }
        .margin({
          top: 50
        })
        .width('90%')
        .aspectRatio(1)
        .justifyContent(FlexAlign.Center)
        .padding(24)

        // 唱针
        Image($r('app.media.ic_stylus'))
          .width(200)
          .aspectRatio(1)
          .rotate({
            angle: -55,
            centerX: 100,
            centerY: 30
          })
          .animation({
            duration: 500
          })
      }

      // 歌曲信息
      Stack() {
        // 第一个
        Column({ space: 8 }) {
          Text(this.playState.name)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4bb0c4')
          Text(this.playState.author)
            .fontSize(18)
            .fontColor('#4bb0c4')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .zIndex(1)

        // 第二个
        Column({ space: 8 }) {
          Text(this.playState.name)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#ec5c87')
          Text(this.playState.author)
            .fontSize(18)
            .fontColor('#ec5c87')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .zIndex(2)

        // 第三个
        Column({ space: 8 }) {
          Text(this.playState.name)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          Text(this.playState.author)
            .fontSize(18)
            .fontColor(Color.White)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .zIndex(3)
      }
      .layoutWeight(1)

      // 操作
      Row() {
        Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC' } }) {
          Image($r("app.media.ic_like"))
            .fillColor(Color.White)
            .width(24)
        }

        Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc' } }) {
          Image($r("app.media.ic_comment_o"))
            .fillColor(Color.White)
            .width(18)
        }

        Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131' } }) {
          Image($r("app.media.ic_bells_o"))
            .fillColor(Color.White)
            .width(24)
        }

        Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371' } }) {
          Image($r("app.media.ic_download_o"))
            .fillColor(Color.White)
            .width(24)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

      // 播放
      Column() {
        // 进度条
        Row({ space: 4 }) {
          Text(this.number2time(this.playState.time))
            .fontSize(12)
            .fontColor(Color.White)
          Slider({
            value: this.playState.time,
            min: 0,
            max: this.playState.duration
          })
            .layoutWeight(1)
            .blockColor(Color.White)
            .selectedColor(Color.White)
            .trackColor('#ccc5c5c5')
            .trackThickness(2)
          Text(this.number2time(this.playState.duration))
            .fontSize(12)
            .fontColor(Color.White)
        }
        .width('100%')
        .padding(24)

        // 切换
        Row() {
          Image($r('app.media.ic_auto'))
            .fillColor(Color.White)
            .width(30)

          Image($r("app.media.ic_prev"))
            .fillColor(Color.White)
            .width(30)
            .onClick(
              ()=>{
                AVPlayerClass.prevPlay()
              }
            )
          // 播放按钮
          Image(this.playState.isPlay ?$r('app.media.ic_pause'):$r('app.media.ic_play'))
          // Image($r('app.media.ic_pause'))
            .fillColor(Color.White)
            .width(50)
            .onClick(()=>{
              if (this.playState.isPlay) {
                AVPlayerClass.player.pause()
              }else{
                AVPlayerClass.player.play()
              }
              this.playState.isPlay = !this.playState.isPlay
              AVPlayerClass.isPlay = !AVPlayerClass.isPlay
            })
          // 下一首
          Image($r('app.media.ic_next'))
            .fillColor(Color.White)
            .width(30)
            .onClick(()=>{
              AVPlayerClass.nextPlay()
            })
          // 播放列表
          Image($r('app.media.ic_song_list'))
            .fillColor(Color.White)
            .width(30)
        }
        .width('100%')
        .padding({
          bottom: 24
        })
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundImage(this.playState.img)
    .backgroundImageSize(ImageSize.Cover)
    .backgroundBlurStyle(BlurStyle.BACKGROUND_ULTRA_THICK)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}