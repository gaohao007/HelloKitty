import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { ADVERTISE_WINDOW_NAME, APP_BOTTOM_HEIGHT, APP_TOP_HEIGHT } from '../constans';
import { getAdvertiseData } from '../Api';
import { PerferenceHelpe } from '../utils';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }


  async onWindowStageCreate(windowStage: window.WindowStage) {

  //读取窗口头部高度
    const  mainWin= windowStage.getMainWindowSync()
    // 沉浸式开发
    mainWin.setWindowLayoutFullScreen(true)

    //头部高度(px2vp 将像素转为vp)
    const topHeight =  px2vp(mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect.height)
    AppStorage.setOrCreate<number>(APP_BOTTOM_HEIGHT,topHeight)

    const bottomHegith=px2vp(mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height)
    AppStorage.setOrCreate<number>(APP_TOP_HEIGHT,bottomHegith)

    //显示广告页
    const result = await getAdvertiseData()
    console.log('advertiseData',JSON.stringify(result))
    const  adSetting = new PerferenceHelpe(this.context)
    await adSetting.SetStartPage(result)
    if (result.isshow){
      //创建广告页
    const win =  await windowStage.createSubWindow(ADVERTISE_WINDOW_NAME)
    await win.showWindow()
    win.setUIContent('pages/Start/Start')
    }

    windowStage.loadContent('pages/Index', (err) => {
     });
  }

  onWindowStageDestroy(): void {

    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {

    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {

    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}