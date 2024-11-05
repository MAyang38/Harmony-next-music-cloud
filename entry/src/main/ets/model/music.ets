import { AVPlayerClass } from "../utils/AVPlayerClass"

export interface SongType {
  img: string
  name: string
  author: string
  url: string
  id: string
}

export class SongTypeModel implements SongType {
  img: string = ''
  name: string = ''
  author: string = ''
  url: string = ''
  id: string = ''

  constructor(model: SongType) {
    this.img = model.img
    this.name = model.name
    this.author = model.author
    this.url = model.url
    this.id = model.id
  }
}

export interface  PlayState{
  duration:number
  time:number
  isPlay:boolean
  PlayMode:'auto'|'repeat'|'random'
  playList:SongType[]
  playIndex:number
  img:string
  name:string
  author:string

}
