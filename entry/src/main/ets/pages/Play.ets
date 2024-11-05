import { songs } from '../constant/music'
import { AVPlayerClass } from '../utils/AVPlayerClass'
import { emitter } from '@kit.BasicServicesKit'
import { PlayState, SongType } from '../model/music'
import { media } from '@kit.MediaKit'
import { MusicListCom } from '../components/MusicListCom'

@Entry
@Component
struct Play {
  // scroller: Scroller | undefined

  @State playState:PlayState = {} as PlayState
  // @State showPlaylist: boolean = false  // 控制底部弹窗的显示状态
  @StorageLink('isShow') isShow: boolean = false;

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
  togglePlaylist(): void {
    this.isShow = !this.isShow
  }

  number2time(number:number){
    // '00:00'
    const second = Math.floor(number/1000)
    if(second >=60){
      const m = Math.floor(second/60)
      return `${m.toString().padStart(2,'0')}:${(second%60).toString().padStart(2,'0')}`
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
            .onChange((value)=>{
              AVPlayerClass.player.seek(value,media.SeekMode.SEEK_PREV_SYNC)
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
            // .fillColor(Color.White)
            .width(30)

          Image($r("app.media.ic_prev"))
            // .fillColor(Color.White)
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
            // .fillColor(Color.White)
            .width(30)
            .onClick(()=>{
              AVPlayerClass.nextPlay()
            })
          // 播放列表
          Image($r('app.media.ic_song_list'))
            .fillColor(Color.White)
            .width(30)
            .onClick(()=>this.togglePlaylist())
        }
        .width('100%')
        .padding({
          bottom: 24
        })
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')


      if (this.isShow) {

        MusicListCom()
        // Stack({ alignContent: Alignment.Bottom }) {
        //   Scroll() {
        //     Text("111")
        //   }
        // }

        // Stack() {
        //   // 背景遮罩
        //   Column() {
        //       // 点击遮罩关闭播放列表
        //   }
        //   .opacity(0.5)
        //   .height('100%')
        //   .width('100%')
        //
        //   // 歌曲列表容器
        //   Column() {
        //     // 歌曲列表标题
        //     Row() {
        //       Text("当前播放列表("+AVPlayerClass.playList.length+")")
        //         .fontSize(20)
        //         .fontWeight(FontWeight.Bold)
        //       // 可选：关闭按钮
        //       Image($r("app.media.ic_close"))
        //         .fillColor(Color.Black)
        //         .width(24)
        //         .onClick(() => this.togglePlaylist())  // 关闭播放列表
        //     }
        //     .width('100%')
        //     .justifyContent(FlexAlign.SpaceBetween)
        //
        //
        //     // 歌曲列表
        //     Column({ space: 8 }) {
        //       ForEach(AVPlayerClass.playList,(song:SongType) => {
        //         Row() {
        //           Text(song.name)
        //             .fontSize(16)
        //             .fontWeight(FontWeight.Bold)
        //           Text(song.author)
        //             .fontSize(14)
        //             .fontColor('#888')
        //         }
        //         .onClick(() => {
        //           // 处理选择歌曲的逻辑（如播放选中的歌曲）
        //           console.log('选中的歌曲:', song)
        //           // 更新 playState 并播放选中的歌曲
        //           AVPlayerClass.changeMusic(song)
        //           this.showPlaylist = false  // 选择歌曲后关闭播放列表
        //         })
        //       })
        //     }
        //   }
        //   .backgroundColor('#fff')
        //   .padding(16)
        //   .borderRadius(16)
        // }
        // .height('50%')
        // .backgroundColor('#000')
        // .zIndex(9999)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImage(this.playState.img)
    .backgroundImageSize(ImageSize.Cover)
    .backgroundBlurStyle(BlurStyle.BACKGROUND_ULTRA_THICK)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])


  }
}