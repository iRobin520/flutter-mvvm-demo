

class ObjectParser {

  ///解析传参
 static T? parseParam<T>(String name, Object? arguments){
    if (arguments is Map) {
      Map params = arguments;
      var paramValue;
      if (params[name] != null) {
        paramValue = params[name];
      } else {
        paramValue = null;
      }
      if (paramValue != null && !(paramValue is T)) {
        if (T == int) {
          return int.parse(paramValue) as T;
        }
      }
      return paramValue;
    } else {
      return arguments as T?;
    }
  }

}


