12/22/2020 Li Aihong liaihong@trinity-tech.io
**version 6.0.1**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v6.0.1
- Implemented the new extension module to unify the layer for extension modules, such as session, file-transfer, and WebRTC wrapper;
- Removed the deprecated API: public func sendFriendMessage(to target: String, _ withMessage: String) throws;
- Rename sendMessageWithReceipt() to sendFriendMessage();
```

11/20/2020 Li Aihong liaihong@trinity-tech.io

**version 5.6.6**, main changes to previous version:

```markdown
- Adapt to Xcode12.2.
```
09/23/2020 Li Aihong liaihong@trinity-tech.io

**version 5.6.5**, main changes to previous version:

```markdown
- Adapt to versions after swift5.1
```

08/11/2020 Li Aihong liaihong@trinity-tech.io

**version 5.6.4**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v5.6.3
```

07/24/2020 Li Aihong liaihong@trinity-tech.io

**version 5.6.3**, main changes to previous version:

```markdown
- Support the attribute of TurnServerInfo param to public.
```

07/07/2020 Li Aihong liaihong@trinity-tech.io

**version 5.6.2**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v5.6.2
- Support pre-defined secret key as Data.
```

06/24/2020 Li Aihong liaihong@trinity-tech.io

**version 5.6.1**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v5.6.1
- Support pre-defined secret key.
- Support internal extension module for WebRTC calling.
```

06/04/2020 Li Aihong liaihong@trinity-tech.io

**version 5.6.0**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v5.6.0
- Added APIs sendMessage() with receipt.
- fix bulkmsg, update message max size.
```

05/07/2020 Li Aihong liaihong@trinity-tech.io

**version 5.5.1**, main changes to previous version:

```markdown
Upgrade native carrier sdk to be v5.5.1 with updates listed:
- Improve implementation of bulk message sending/receiving
- fix group info store issue when killed by system.
```

03/28/2020 Li Aihong liaihong@trinity-tech.io

**version 5.5.0**, main changes to previous version:

```markdown
- Be able to create multiple carrier instances now, which required by Trinity (or elastOS). General application over Carrier network should still keep using singleton carrier instance under application context.
- Carrier::getGroups() now can get the groups that created or joined over the previous online time;
- All groups in Carrier context updated to share one GroupHandler, and become part of CarrierHandler. 
- Update the prototype of methods of Carrier::createGroup()and Carrier::joinGroup(), which removed GroupHandler from parameter list.
```

11/19/2019 Li Aihong liaihong@elastos.org

**version 5.4.4**, main changes to previous version:

```markdown
- Fix crash issue for group invitation
- Fix bugs for acquireFileName(by:) & acquireFileId(by:)
- Adapt Xcode11.2.1
```

10/23/2019 Li Aihong liaihong@elastos.org

**version 5.4.3**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v5.4.2
```

09/29/2019 Li Aihong liaihong@elastos.org

**version 5.4.2**, main changes to previous version:

```markdown
- Update swift version and support for swift5.1
- Adapt Xcode11.
```

09/19/2019 Li AiHong aihongli2019@gmail.com

**version 5.4.1**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v5.4.1
- Sync last native ela_carrier.h
```

08/20/2019 Li AiHong aihongli2019@gmail.com

**version 5.4.0**, main changes to previous version:

```markdown
- CarrierOptions add the function of setting log level.
- API changes in sending/receiving messages.
```

08/14/2019 Li AiHong aihongli2019@gmail.com

**version 5.3.3**, main changes to previous version:

```markdown
- Fix filetransfer bug
- Fix carrier Goup invite callback bug
- Use travis-ci.com
```

08/07/2019 Li AiHong aihongli2019@gmail.com

**version 5.3.3**, main changes to previous version:

```markdown
- Upgrade native carrier sdk to be v5.3.4
```

05/30/2019 Li AiHong aihongli2019@gmail.com

**version 5.3.2**, main changes to previous version:

```markdown
- Resolve crash when ccookies is nil
- Upgrade native carrier sdk to be v5.3.3
```

05/06/2019 Li AiHong aihongli2019@gmail.com

**version 5.3.1**, main changes to previous version:

```markdown
- Support offline message sending/receiving;
```

04/12/2019 Li AiHong aihongli2019@gmail.com

**version 5.2.4**, main changes to previous version:

```markdown
- Support staticlibrary for ElastosCarrierSDK in the Xcode10.2
```

03/29/2019 Tang Zhilong stiartsly@gmail.com

**version 5.2.3**, main changes to previous version:

```markdown
- Update swift version from 3.0 to 4.2 release
- Support ElastosCarrierSDK with swift5.0 for pod install
```


03/19/2019 Tang Zhilong stiartsly@gmail.com

**version 5.2.2**, main changes to previous version:

```markdown
- ElastosCarrierSDK support for pod 
- Update dynamic framework 
```


