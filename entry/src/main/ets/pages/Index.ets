import { songs } from '../constant/music'
import router from '@ohos.router'
import { SongType } from '../model/music'
import { AVPlayerClass } from '../utils/AVPlayerClass'
import { Player } from '../components/Player'

@Entry
@Component
struct Index {
  // @State canShow:boolean = AVPlayerClass.isPlay
  @StorageLink('canShow') canShow: boolean = false;

  build() {
    Column() {
      Row() {
        Text('猜你喜欢')
          .fontColor('#fff')
      }
      .width('100%')
      .padding(24)
      Row() {
        List({ space: 10 }) {
          ForEach(songs, (song: SongType) => {
            ListItem() {
              Row() {
                Image(song.img)
                  .width(60)
                  .borderRadius(8)
                Column({ space: 10 }) {
                  Text(song.name)
                    .fontColor('#fff')
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
                      .fontColor('#fff')
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
      }
      .layoutWeight(1)

      if(this.canShow) {
        Player()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#111113')
    .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])



  }
}
