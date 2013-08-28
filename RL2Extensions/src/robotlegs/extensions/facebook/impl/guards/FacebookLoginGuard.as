//------------------------------------------------------------------------------
//  Copyright (c) 2012-2013 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.extensions.facebook.impl.guards {
import com.facebook.graph.data.FacebookAuthResponse;

public class FacebookLoginGuard {
    [Inject]
    public var authResponse:FacebookAuthResponse;

    public function approve():Boolean {
        return authResponse.uid != null && authResponse.accessToken != null;
    }
}
}