// //ToDoList.ets
// import { ToDo } from './ToDo';
// import { ToDoListItem } from './ToDoListItem';
// @Entry
// @Component
// struct ToDoList {
//   @State toDoData: ToDo[] = []
//   @Watch('onEditModeChange') @State isEditMode: boolean = false
//   @State selectedItems: ToDo[] = []
//   private availableThings: string[] = ['读书', '运动', '旅游', '听音乐', '看电影', '唱歌']
//
//   onEditModeChange() {
//     if(!this.isEditMode) {
//       this.selectedItems = []
//     }
//   }
//
//   build() {
//     Column() {
//       Row() {
//         if (this.isEditMode) {
//           Text('X')
//             .fontSize(20)
//             .onClick(() => {
//               this.isEditMode = false;
//             })
//             .margin({ left: 20, right: 20})
//         } else {
//           Text('待办')
//             .fontSize(36)
//             .margin({ left: 40 })
//           Blank()
//           Text('+')   //提供新增列表项入口，即给新增按钮添加点击事件
//             .onClick(() => {
//               TextPickerDialog.show({
//                 range: this.availableThings,
//                 onAccept: (value: TextPickerResult) => {
//                   let arr = Array.isArray(value.index) ? value.index : [value.index];
//                   for(let i = 0; i < arr.length; i++) {
//                     this.toDoData.push(new ToDo(this.availableThings[arr[i]])); // 新增列表项数据toDoData(可选事项)
//                   }
//                 },
//               })
//             })
//         }
//         List({ space: 10 }) {
//           ForEach(this.toDoData, (toDoItem: ToDo) => {
//             ListItem() {
//               // 将toDoData的每个数据放入到以model的形式放进ListItem里
//               ToDoListItem({
//                 isEditMode: this.isEditMode,
//                 toDoItem: toDoItem,
//                 selectedItems: this.selectedItems })
//             }
//           }, (toDoItem: ToDo) => toDoItem.key.toString())
//         }
//       }
//     }
//   }
// }