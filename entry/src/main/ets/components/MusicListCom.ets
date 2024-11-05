

import { PlayerConstants } from '../common/constants/PlayerConstants';
import { StyleConstants } from '../common/constants/StyleConstants';
import { PlayState, SongType } from '../model/music';
import { AVPlayerClass } from '../utils/AVPlayerClass';
import { emitter } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';


@Preview
@Component
export struct MusicListCom {
  @StorageProp('selectIndex') selectIndex: number = 0;
  // @StorageLink('isShow') isShow: boolean = false;
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
    // Scroll(){
    Column(){
      Row({space:20}){
        Text("播放列表")
          .textAlign(TextAlign.Start)
          .padding({
              left:0
          })

        Image($r('app.media.ic_close'))
          .height('20vp')
          .width('20vp')
          .padding({
            right:0
          })
          .onClick(()=>{
            AppStorage.setOrCreate('isShow',false )
          })
      }

      List({ space: 10 }) {
        ForEach(AVPlayerClass.playList, (song: SongType) => {
          ListItem() {
            Row() {
              Image(song.img)
                .width(60)
                .borderRadius(8)
              Column({ space: 10 }) {
                Text(song.name)
                  .fontColor('#ff131313')
                Row({ space: 5 }) {
                  Text('VIP')
                    .fontSize(14)
                    .fontColor(Color.Orange)
                    .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                    .borderRadius(16)
                    .border({
                      width: 1,
                      color: Color.Orange
                    })
                  Text(song.author)
                    .fontColor('#ff0a0a0a')
                }
              }
              .padding({
                left: 16
              })
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Image($r('app.media.ic_more'))
                .width(20)
            }
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Play',
            })

            AVPlayerClass.singlePlay(song)
          })
        })
        ListItem(){
          Text('没有更多啦~')
            .padding(8)
            .width('100%')
            .fontColor('#ccc')
            .textAlign(TextAlign.Center)
        }
      }
      .width('100%')
      .height('100%')
      .padding({
        left: 24,
        right: 24
      })

    Row() {
      Row() {

        // .alignItems(HorizontalAlign.Start)
      }
      // .layoutWeight(PlayerConstants.LAYOUT_WEIGHT_PLAYER_CONTROL)

      Blank()

      Row() {
        Image($r('app.media.ic_prev_red'))
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          .margin({ right: $r('app.float.control_icon_margin') })
          .displayPriority(PlayerConstants.DISPLAY_PRIORITY_TWO)
          .onClick(()=>{
            AVPlayerClass.prevPlay()
          })

        Image(AVPlayerClass.isPlay ? $r('app.media.ic_play') : $r('app.media.ic_pause'))
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          .displayPriority(PlayerConstants.DISPLAY_PRIORITY_THREE)
          .onClick(()=>{
            if (AVPlayerClass.isPlay){
              AVPlayerClass.player.pause()
            }else{
              AVPlayerClass.player.play()
            }
            AVPlayerClass.isPlay = !AVPlayerClass.isPlay
          })

        Image($r('app.media.ic_next_red'))
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          .margin({
            right: $r('app.float.control_icon_margin'),
            left: $r('app.float.control_icon_margin')
          })
          .displayPriority(PlayerConstants.DISPLAY_PRIORITY_TWO)
          .onClick(()=>{
            AVPlayerClass.nextPlay()
          })
        Image($r('app.media.ic_music_list'))
          .height($r('app.float.control_icon_height'))
          .width($r('app.float.control_icon_width'))
          .displayPriority(PlayerConstants.DISPLAY_PRIORITY_ONE)
      }
      .width('30%')
      .justifyContent(FlexAlign.End)
    }
    }
    .width(StyleConstants.FULL_WIDTH)
    .height('60%')
    .backgroundColor($r('app.color.music_list_background'))
    .padding({
      left: $r('app.float.player_padding'),
      right: $r('app.float.player_padding')
    })
    .position({
      x: 0,
      y: StyleConstants.FULL_HEIGHT
      // y: '50%'
    })
    .translate({
      x: 0,
      // y: StyleConstants.TRANSLATE_PLAYER_Y
      y: '-100%'
    })
    }

}