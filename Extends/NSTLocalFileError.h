//
//  NSTLocalFileError.h
//  Pods
//
//  Created by Anatoly Shcherbinin on 5.04.22.
//

#ifndef NSTLocalFileError_h
#define NSTLocalFileError_h

///Quick error domain for errors that should be generated and handled localy in one source file
#define NSTLocalFileErrorDomain (@__FILE_NAME__)

///Convenience method for generation errors with localized description
///Generated error will have file name where occured as domain and code as line
#define NSTLocalFileErrorWithMessage(message) _localFileErrorWithMessage(NSTLocalFileErrorDomain, __LINE__, (message))

///Convenience method for generation errors with cpecefied code
///Can be used if error handled in the same file and error handling if depends on code
#define NSTLocalFileErrorWithCode(code) _localFileErrorWithMessage(NSTLocalFileErrorDomain, (code), nil)

CF_INLINE NSError *_localFileErrorWithMessage(NSErrorDomain domain, NSInteger code, NSString *message) {
    return [NSError errorWithDomain:domain
                               code:code
                           userInfo:( nil == message
        ? nil
        : @ { NSLocalizedDescriptionKey: message }
    )];
}

#endif /* NSTLocalFileError_h */
