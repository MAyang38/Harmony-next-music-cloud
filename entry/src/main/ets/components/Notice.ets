import { image } from "@kit.ImageKit";
import { notificationManager } from "@kit.NotificationKit";


export class Notice{


  static publishBasicText(){
    let imagePixelMap : image.PixelMap | undefined = undefined;
    let color = new ArrayBuffer(4);
    image.createPixelMap(color,{size:{height:1,width:1}}).then((data:image.PixelMap)=>{
      imagePixelMap = data;
    })

    let notificationRequest: notificationManager.NotificationRequest={
      id:1000,
      content:{
        notificationContentType:notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal:{
          title:'三无',
          text:'早睡早起'
        }
      },
      largeIcon:imagePixelMap
    }
    notificationManager.publish(notificationRequest)
  }
}