# Build status — HSON 3-Feature Menu v5.0.0

## Included
- Three visible menu actions, authored by HSON: Auto nhập ảnh, Auto chia beat, Auto nhập phân cảnh.
- The old Code gần nhất card is removed from the menu; QR decoding remains internal to Multi Scene; the last-code cache and preview were removed.
- Menu card tags map to the existing engine entrypoints 0, 2 and 3.
- Target bundle filter and runtime window check use `com.frontierdesign.videostar1`, matching the supplied Video Star runtime report.
- Floating launcher and independent menu remain separate from the feature engine.
- Multi Scene is deliberately guided: select one QR image per selected scene, choose common media, confirm native import prompts, and press Video Star's native Create when requested. HSON waits for the editor to close before proceeding; it does not invent a private Create selector.
- Existing Video Star authorization logic is not patched or bypassed.

## Static checks
- Menu exposes exactly three feature cards.
- Each card maps to the intended feature engine entrypoint.
- Runtime host bundle ID and tweak filter match the scanner report.
- The package build still compiles the independent menu and feature engine only; the original dylib is not linked.

## Not verified
- No iOS SDK / Theos build was run in this Linux container.
- No runtime test was performed on the target iPhone with Video Star 14.3.3.
- Private class names, KVC keys, method signatures, response initializers and editor state transitions remain dependent on the installed app version.
- Auto layer replacement, beat splitting and Multi Scene may need on-device adjustments. A successful static check does not prove these private operations work at runtime.

**100% operation cannot be guaranteed without compiling with Theos and testing all three workflows on the target device.**

## CI compile-error patch (after v5.0.0)
- Replaced the ambiguous `NSObject (VSPrivate) -currentTime` declaration with a typed `objc_msgSend` helper returning `CMTime`, avoiding collisions with AVFAudio's `NSTimeInterval currentTime` declarations.
- Updated both beat-split time reads to use that helper.
- Promoted weak `self` to a strong local before reading ivars in asynchronous completion blocks; removed direct `ws->_ivar` accesses.
- Static source checks and Bash/YAML workflow syntax checks pass after this patch.
- Theos compilation and device runtime verification are still pending; do not treat this source patch as proof of a successful build.


## Code-signing header padding patch
- Added `-Wl,-headerpad,0x4000` to `HSONModernMenu_LDFLAGS` to reserve 16 KiB in the Mach-O header/load-command area for downstream `LC_CODE_SIGNATURE` insertion.
- This addresses the specific `Can't find CodeSignature segment` / `Can't find free space of LoadCommands` signing failure mode shown in the user's screenshot, but must be confirmed by rebuilding and signing on the target environment.
