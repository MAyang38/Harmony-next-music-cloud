

import { PlayerConstants } from '../common/constants/PlayerConstants';
import { StyleConstants } from '../common/constants/StyleConstants';
import { PlayState, SongType } from '../model/music';
import { AVPlayerClass } from '../utils/AVPlayerClass';
import { emitter } from '@kit.BasicServicesKit';


@Preview
@Component
export struct Player {
  @StorageProp('selectIndex') selectIndex: number = 0;
  @StorageLink('isPlay') isPlay: boolean = AVPlayerClass.isPlay;
  @State currentIsPlay :boolean = false
  @State songList: SongType[] = AVPlayerClass.playList;
  @State playState:PlayState = {} as PlayState

  aboutToAppear(): void {
    emitter.on({
      eventId:1
    },(data)=>{
      // console.log(JSON.stringify(data.data))
      this.playState = data.data as PlayState
    })
  }
  build() {
    Row() {
      Row() {
        Image(this.playState.img)
          .height($r('app.float.cover_height'))
          .width($r('app.float.cover_width'))
          .borderRadius($r('app.float.label_border_radius'))
          .margin({ right: $r('app.float.cover_margin') })
          .rotate({ angle: this.isPlay ? PlayerConstants.ROTATE : 0 })
          .animation({
            duration: PlayerConstants.ANIMATION_DURATION,
            iterations: PlayerConstants.ITERATIONS,
            curve: Curve.Linear
          })
        Column() {
          Text(this.playState.name)
            .fontColor($r('app.color.song_name'))
            .fontSize(10)
          Row() {
            Image($r('app.media.ic_vip'))
              .height('16vp')
              .width('16vp')
              // .height($r('app.float.vip_icon_height'))
              // .width($r('app.float.vip_icon_width'))
              // .margin({ right: $r('app.float.vip_icon_margin') })
            Text(this.playState.author)
              // .fontColor($r('app.color.singer'))
              .fontSize(10)
              .opacity($r('app.float.singer_opacity'))
          }
        }
        // .alignItems(HorizontalAlign.Start)
      }
      // .layoutWeight(PlayerConstants.LAYOUT_WEIGHT_PLAYER_CONTROL)

      Blank()

      Row() {
        // Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC' } }) {
        //   Image($r("app.media.ic_like"))
        //     .fillColor(Color.White)
        //     .width(24)
        // }

        Image($r('app.media.ic_prev_red'))
          .fillColor(Color.Black)
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          .margin({ right: $r('app.float.control_icon_margin') })
          // .displayPriority(PlayerConstants.DISPLAY_PRIORITY_TWO)
          .onClick(()=>{
            AVPlayerClass.prevPlay()
          })



        Image(this.currentIsPlay ? $r('app.media.ic_play') : $r('app.media.ic_pause'))
          .fillColor(Color.Black)
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          // .displayPriority(PlayerConstants.DISPLAY_PRIORITY_THREE)
          .onClick(()=>{
            if (this.currentIsPlay){
              AVPlayerClass.player.pause()
            }else{
              AVPlayerClass.player.play()
            }
            this.currentIsPlay = !this.currentIsPlay
            AVPlayerClass.isPlay = !AVPlayerClass.isPlay
          })

        Image($r('app.media.ic_next_red'))
          .fillColor(Color.Black)
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          .margin({
            right: $r('app.float.control_icon_margin'),
            left: $r('app.float.control_icon_margin')
          })
          // .displayPriority(PlayerConstants.DISPLAY_PRIORITY_TWO)
          .onClick(()=>{
            AVPlayerClass.nextPlay()
          })
        Image($r('app.media.ic_music_list'))
          .fillColor(Color.Black)
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          .margin({
            right: $r('app.float.control_icon_margin'),
            left: $r('app.float.control_icon_margin')
          })
          // .displayPriority(PlayerConstants.DISPLAY_PRIORITY_ONE)
      }
      .width('30%')
      .justifyContent(FlexAlign.End)
    }
    .width(StyleConstants.FULL_WIDTH)
    .height($r('app.float.player_area_height'))
    .backgroundColor($r('app.color.player_background'))
    .padding({
      left: $r('app.float.player_padding'),
      right: $r('app.float.player_padding')
    })
    .position({
      x: 0,
      y: StyleConstants.FULL_HEIGHT
    })
    .translate({
      x: 0,
      y: StyleConstants.TRANSLATE_PLAYER_Y
    })
  }
}