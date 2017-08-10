//
//  DataModel.m
//  Coding
//
//  Created by 安宁 on 2017/6/30.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "DataModel.h"

@interface DataModel ()<NSSecureCoding>

@end

@implementation DataModel


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _str = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"str"];
    }
    
    return self ;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_str forKey:@"str"];
}


+(BOOL)supportsSecureCoding
{
    return YES ;
}

- (NSDictionary *)propertyClassesByName

{
    
    // Check for a cached value (we use _cmd as the cache key,
    
    // which represents @selector(propertyNames))
    
    NSMutableDictionary *dictionary = objc_getAssociatedObject([self class], _cmd);
    
    if (dictionary)
        
    {
        
        return dictionary;
        
    }
    
    // Loop through our superclasses until we hit NSObject
    
    dictionary = [NSMutableDictionary dictionary];
    
    Class subclass = [self class];
    
    while (subclass != [NSObject class])
        
    {
        
        unsigned int propertyCount;
        
        objc_property_t *properties = class_copyPropertyList(subclass,
                                                             
                                                             &amp;propertyCount);
        
        for (int i = 0; i &lt; propertyCount; i++)
            
        {
            
            // Get property name
            
            objc_property_t property = properties[i];
            
            const char *propertyName = property_getName(property);
            
            NSString *key = @(propertyName);
            
            // Check if there is a backing ivar
            
            char *ivar = property_copyAttributeValue(property, &quot;V&quot;);
            
            if (ivar)
                
            {
                
                // Check if ivar has KVC-compliant name
                
                NSString *ivarName = @(ivar);
                
                if ([ivarName isEqualToString:key] ||
                    
                    [ivarName isEqualToString:[@&quot;_&quot; stringByAppendingString:key]])
                    
                {
                    
                    // Get type
                    
                    Class propertyClass = nil;
                    
                    char *typeEncoding = property_copyAttributeValue(property, &quot;T&quot;);
                    
                    switch (typeEncoding[0])
                    
                    {
                            
                        case &#039;c&#039;: // Numeric types
                            
                        case &#039;i&#039;:
                            
                        case &#039;s&#039;:
                            
                        case &#039;l&#039;:
                            
                        case &#039;q&#039;:
                            
                        case &#039;C&#039;:
                            
                        case &#039;I&#039;:
                            
                        case &#039;S&#039;:
                            
                        case &#039;L&#039;:
                            
                        case &#039;Q&#039;:
                            
                        case &#039;f&#039;:
                            
                        case &#039;d&#039;:
                            
                        case &#039;B&#039;:
                            
                        {
                            
                            propertyClass = [NSNumber class];
                            
                            break;
                            
                        }
                            
                        case &#039;*&#039;: // C-String
                            
                        {
                            
                            propertyClass = [NSString class];
                            
                            break;
                            
                        }
                            
                        case &#039;@&#039;: // Object
                            
                        {
                            
                            //TODO: get class name
                            
                            break;
                            
                        }
                            
                        case &#039;{&#039;: // Struct
                            
                            {
                                
                                propertyClass = [NSValue class];
                                
                                break;
                                
                            }
                            
                        case &#039;[&#039;: // C-Array
                                    
                                    case &#039;(&#039;: // Enum
                                                
                                                case &#039;#&#039;: // Class
                                                
                                                case &#039;:&#039;: // Selector
                                                
                                                case &#039;^&#039;: // Pointer
                                                
                                                case &#039;b&#039;: // Bitfield
                                                
                                                case &#039;?&#039;: // Unknown type
                                                
                                                default:
                                                
                                                {
                                                    
                                                    propertyClass = nil; // Not supported by KVC
                                                    
                                                    break;
                                                    
                                                }
                                                
                                                }
                                                
                                                free(typeEncoding);
                                                
                                                // If known type, add to dictionary
                                                
                                                if (propertyClass) dictionary[propertyName] = propertyClass;
                                                
                                                }
                                                
                                                free(ivar);
                                                
                                                }
                                                
                                                }
                                                
                                                free(properties);
                                                
                                                subclass = [subclass superclass];
                                                
                                                }
                                                
                                                // Cache and return dictionary
                                                
                                                objc_setAssociatedObject([self class], _cmd, dictionary, 
                                                                         
                                                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                                                
                                                return dictionary;
                                                
                                                }

@end
