package kr.co.wisetracker.dot;

import android.content.Context;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sdk.wisetracker.base.open.model.User;
import com.sdk.wisetracker.base.tracker.common.log.WiseLog;
import com.sdk.wisetracker.base.tracker.data.manager.SessionDataManager;
import com.sdk.wisetracker.new_dot.open.DOT;

import java.lang.reflect.Type;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** DotPlugin */
public class DotPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "dot");
    channel.setMethodCallHandler(this);
    this.applicationContext = flutterPluginBinding.getApplicationContext();
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "dot");
    channel.setMethodCallHandler(new DotPlugin());
  }

  private String getString(MethodCall call, String key){
    String result = "";
    if( call.arguments != null && call.hasArgument(key) ){
      result = (String)(call.argument(key));
    }
    return result;
  }
  private String[] getStringArray(MethodCall call, String key){
    String[] result = null;
    if( call.arguments != null && call.hasArgument(key)  ) {
      if ((call.argument(key)) instanceof List) {
        result = ((List<String>)(call.argument(key))).toArray(new String[0]);
      }else if ((call.argument(key)) instanceof String[]){
        result = (String[])(call.argument(key));
      }
    }
    return result;
  }
  private double getDouble(MethodCall call, String key){
    double result = 0;
    if( call.arguments != null && call.hasArgument(key)  ){
      result = (double)(call.argument(key));
    }
    return result;
  }
  private double[] getDoubleArray(MethodCall call , String key ){
    double[] result = null;
    if( call.arguments != null && call.hasArgument(key)  ) {
      if ((call.argument(key)) instanceof List) {
        List _dl = (List)(call.argument(key));
        if( _dl != null && _dl.size() > 0 ){
          result = new double[_dl.size()];
          for(int ix =0; ix< _dl.size(); ix++){
            if( _dl.get(ix) instanceof Double ){
              result[ix] = ((Double)_dl.get(ix)).doubleValue();
            }else if( _dl.get(ix) instanceof Integer ){
              result[ix] = ((Integer)_dl.get(ix)).intValue();
            }
          }
        }
      }else if ((call.argument(key)) instanceof double[]) {
        result = (double[])(call.argument(key));
      }
    }
    return result;
  }
  private int getInt(MethodCall call, String key){
    int result = 0;
    if( call.arguments != null && call.hasArgument(key)  ){
      result = (int)(call.argument(key));
    }
    return result;
  }
  private int[] getIntArray(MethodCall call , String key ){
    int[] result = null;
    if( call.arguments != null && call.hasArgument(key)  ) {
      if ((call.argument(key)) instanceof List) {
        List<Integer> _il = (List<Integer>)(call.argument(key));
        if( _il != null && _il.size() > 0 ){
          result = new int[_il.size()];
          for(int ix =0; ix< _il.size(); ix++){
            result[ix] = _il.get(ix).intValue();
          }
        }
      }else if ((call.argument(key)) instanceof int[]) {
        result = (int[])(call.argument(key));
      }
    }
    return result;
  }
  private long getLong(MethodCall call, String key){
    long result = 0;
    if( call.arguments != null && call.hasArgument(key)  ){
      result = (long)(call.argument(key));
    }
    return result;
  }
  private boolean getBoolean(MethodCall call, String key){
    boolean flag = false;
    if( call.arguments != null && call.hasArgument(key)  ){
        flag = (boolean)(call.argument(key));
    }
    return flag;
  }
  private Map getMap(MethodCall call, String key) {
    Map<String, Object> resultMap = new HashMap<>();
    if( call.arguments != null && call.hasArgument(key)  ){
        resultMap = (Map)(call.argument(key));
    }
    return resultMap;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    boolean doExecute = false;
    try{
      switch (call.method){
        case "initialization":
          try{
            DOT.init(this.applicationContext);
            doExecute = true;
          }catch(Exception e){
            e.printStackTrace();
          }
          break; // Wisetracker SDK Init

        case "setUser":
          try{
            String userJson = this.getString(call,"userJson");
            if( userJson != null && !userJson.equals("")){
              WiseLog.d("setUser event :" + userJson);
              Gson gson = new Gson();
              Type type = new TypeToken<Map<String, Object>>() {}.getType();
              Map<String, Object> tempMap = new Gson().fromJson(userJson, type);
              String tmpJson = gson.toJson(tempMap.get("_data"));
              User user = new Gson().fromJson(tmpJson, User.class);
              if (user != null) {
                SessionDataManager.getInstance().setUser(user);
                doExecute = true;
              }else{
                WiseLog.d("user is null");
              }
            }else{
              WiseLog.d("user json is null");
            }
          }catch(Exception e){
            e.printStackTrace();
          }
          break;

        case "setUserLogout":
          try {
            SessionDataManager.getInstance().setUserLogout();
            doExecute = true;
          } catch (Exception e) {
            WiseLog.d(e.getMessage());
          }
          break;

        case "onPlayStart":
          try{
            if(call.hasArgument("period")){
              DOT.onPlayStart(this.getInt(call,"period"));
            }else{
              DOT.onPlayStart();
            }
            doExecute = true;
          }catch(Exception e){
            e.printStackTrace();
          }
          break;

        case "onPlayStop":
          try{
            DOT.onPlayStop();
            doExecute = true;
          }catch (Exception e){
            e.printStackTrace();
          }
          break;

        case "onStartPage":
          try{
            DOT.onStartPage(null);
            doExecute = true;
          }catch(Exception e){
            e.printStackTrace();
          }
          break;

        case "onStopPage":
          try{
            DOT.onStopPage();
            doExecute = true;
          }catch (Exception e){
            e.printStackTrace();
          }
          break;

        case "logScreen":
          try{
            WiseLog.d("log screen event");
            String pageJson = this.getString(call,"pageJson");
            if( pageJson != null && !pageJson.equals("")){
              WiseLog.d("raw data : " + pageJson);
              Type type = new TypeToken<Map<String, Object>>() {}.getType();
              Map<String, Object> pageMap = new Gson().fromJson(pageJson, type);
              if (pageMap != null) {
                DOT.logScreen(pageMap);
                doExecute = true;
              }else{
                WiseLog.d("page map is null");
              }
            }else{
              WiseLog.d("page json is null");
            }
          }catch (Exception e){
            e.printStackTrace();
          }
          break;

        case "logPurchase":
          try{
            WiseLog.d("log purchase event");
            String purchaseJson = this.getString(call,"purchaseJson");
            if( purchaseJson != null && !purchaseJson.equals("")){
              WiseLog.d("raw data : " + purchaseJson);
              Type type = new TypeToken<Map<String, Object>>() {}.getType();
              Map<String, Object> purchaseMap = new Gson().fromJson(purchaseJson, type);
              if (purchaseMap != null) {
                DOT.logPurchase(purchaseMap);
                doExecute = true;
              }else{
                WiseLog.d("purchase map is null");
              }
            }else{
              WiseLog.d("purchase json is null");
            }
          }catch (Exception e){
            e.printStackTrace();
          }
          break;

        case "logEvent":
          try{
            WiseLog.d("log conversion event");
            Map<String, Object> conversionMap = this.getMap(call,conversionJson);
            DOT.logEvent(conversionMap);
            String conversionJson = this.getString(call,"conversionJson");
            doExecute = true;
            // if( conversionJson != null && !conversionJson.equals("")){
            //   WiseLog.d("raw data : " + conversionJson);
            //   Type type = new TypeToken<Map<String, Object>>() {}.getType();
            //   Map<String, Object> conversionMap = new Gson().fromJson(conversionJson, type);
            //   if (conversionMap != null) {
            //     DOT.logEvent(conversionMap);
            //     doExecute = true;
            //   }else{
            //     WiseLog.d("conversion map is null");
            //   }
            }else{
              WiseLog.d("conversion json is null");
            }
          }catch (Exception e){
            e.printStackTrace();
          }
          break;


        case "logClick":
          try{
            WiseLog.d("log click event");
            String clickJson = this.getString(call,"clickJson");
            if( clickJson != null && !clickJson.equals("")){
              WiseLog.d("raw data : " + clickJson);
              Type type = new TypeToken<Map<String, Object>>() {}.getType();
              Map<String, Object> clickMap = new Gson().fromJson(clickJson, type);
              if (clickMap != null) {
                DOT.logClick(clickMap);
                doExecute = true;
              }else{
                WiseLog.d("click map is null");
              }
            }else{
              WiseLog.d("click json is null");
            }
          }catch (Exception e){
            e.printStackTrace();
          }
          break;
      }
    }catch(Exception e){
      e.printStackTrace();
    }finally {
      // callback return to flutter layer
      if( doExecute ){
        result.success(call.method+" API calling success.");
      }else{
        result.notImplemented();
      }
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
