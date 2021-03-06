######################################################################

!define APP_NAME "gta5view"
!define COMP_NAME "Syping"
!define WEB_SITE "https://gta5view.syping.de/"
!define VERSION "1.9.1.0"
!define COPYRIGHT "Copyright © 2016-2020 Syping"
!define DESCRIPTION "Grand Theft Auto V Savegame and Snapmatic Viewer/Editor"
!define INSTALLER_NAME "gta5view_setup.exe"
!define MAIN_APP_EXE "gta5view.exe"
!define INSTALL_TYPE "SetShellVarContext all"
!define REG_ROOT "HKLM"
!define REG_APP_PATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${MAIN_APP_EXE}"
!define UNINSTALL_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
!define LICENSE_TXT "../LICENSE"

######################################################################

VIProductVersion  "${VERSION}"
VIAddVersionKey "ProductName"  "${APP_NAME}"
VIAddVersionKey "ProductVersion"  "${VERSION}"
VIAddVersionKey "CompanyName"  "${COMP_NAME}"
VIAddVersionKey "LegalCopyright"  "${COPYRIGHT}"
VIAddVersionKey "FileDescription"  "${DESCRIPTION}"
VIAddVersionKey "FileVersion"  "${VERSION}"

######################################################################

!include "x64.nsh"
SetCompressor LZMA
Name "${APP_NAME}"
Caption "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
#BrandingText "${APP_NAME}"
XPStyle on
Unicode true
InstallDirRegKey "${REG_ROOT}" "${REG_APP_PATH}" ""
InstallDir "$PROGRAMFILES64\Syping\gta5view"

######################################################################

!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING

!define MUI_LANGDLL_REGISTRY_ROOT "${REG_ROOT}"
!define MUI_LANGDLL_REGISTRY_KEY "${UNINSTALL_PATH}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

!insertmacro MUI_PAGE_WELCOME

!ifdef LICENSE_TXT
!insertmacro MUI_PAGE_LICENSE "${LICENSE_TXT}"
!endif

!insertmacro MUI_PAGE_DIRECTORY

!ifdef REG_START_MENU
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "gta5view"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${REG_ROOT}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${UNINSTALL_PATH}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${REG_START_MENU}"
!insertmacro MUI_PAGE_STARTMENU Application $SM_Folder
!endif

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN "$INSTDIR\${MAIN_APP_EXE}"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM

!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "TradChinese"

!insertmacro MUI_RESERVEFILE_LANGDLL

######################################################################

Function .onInit
!insertmacro MUI_LANGDLL_DISPLAY
!ifdef WIN32
	MessageBox MB_OK|MB_ICONSTOP "Windows 32-Bit is not supported anymore!"
	Quit
!endif
SetRegView 64
FunctionEnd

######################################################################

Section -MainProgram
${INSTALL_TYPE}
SetOverwrite ifnewer
SetOutPath "$INSTDIR"
File "../build/gta5view.exe"
File "/opt/llvm-mingw/x86_64-w64-mingw32/bin/libc++.dll"
File "/opt/llvm-mingw/x86_64-w64-mingw32/bin/libunwind.dll"
File "/usr/local/lib/x86_64-w64-mingw32/openssl/bin/libcrypto-1_1-x64.dll"
File "/usr/local/lib/x86_64-w64-mingw32/openssl/bin/libssl-1_1-x64.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/bin/Qt5Core.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/bin/Qt5Gui.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/bin/Qt5Network.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/bin/Qt5Svg.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/bin/Qt5Widgets.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/bin/Qt5WinExtras.dll"
SetOutPath "$INSTDIR\lang"
File "../build/gta5sync_en_US.qm"
File "../build/gta5sync_de.qm"
File "../build/gta5sync_fr.qm"
File "../build/gta5sync_ko.qm"
File "../build/gta5sync_ru.qm"
File "../build/gta5sync_uk.qm"
File "../build/gta5sync_zh_TW.qm"
File "../build/qtbase_en_GB.qm"
File "../res/qt5/qtbase_de.qm"
File "../res/qt5/qtbase_fr.qm"
File "../res/qt5/qtbase_ko.qm"
File "../res/qt5/qtbase_ru.qm"
File "../res/qt5/qtbase_uk.qm"
File "../res/qt5/qtbase_zh_TW.qm"
SetOutPath "$INSTDIR\imageformats"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qgif.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qicns.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qico.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qjpeg.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qsvg.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qtga.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qtiff.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qwbmp.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/imageformats/qwebp.dll"
SetOutPath "$INSTDIR\platforms"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/platforms/qwindows.dll"
SetOutPath "$INSTDIR\styles"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/styles/qcleanlooksstyle.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/styles/qplastiquestyle.dll"
File "/usr/local/lib/x86_64-w64-mingw32/qt5/plugins/styles/qwindowsvistastyle.dll"
SectionEnd

######################################################################

Section -Icons_Reg
SetOutPath "$INSTDIR"
WriteUninstaller "$INSTDIR\uninstall.exe"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
CreateDirectory "$SMPROGRAMS\$SM_Folder"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk" "$INSTDIR\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\gta5view Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!insertmacro MUI_STARTMENU_WRITE_END
!endif

!ifndef REG_START_MENU
CreateDirectory "$SMPROGRAMS\gta5view"
CreateShortCut "$SMPROGRAMS\gta5view\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\gta5view\Uninstall ${APP_NAME}.lnk" "$INSTDIR\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\gta5view\gta5view Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!endif

WriteRegStr ${REG_ROOT} "${REG_APP_PATH}" "" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayName" "${APP_NAME}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "UninstallString" "$INSTDIR\uninstall.exe"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayIcon" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayVersion" "${VERSION}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "Publisher" "${COMP_NAME}"

!ifdef WEB_SITE
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "URLInfoAbout" "${WEB_SITE}"
!endif
SectionEnd

######################################################################

Section Uninstall
${INSTALL_TYPE}
Delete "$INSTDIR\gta5view.exe"
Delete "$INSTDIR\libc++.dll"
Delete "$INSTDIR\libunwind.dll"
Delete "$INSTDIR\libcrypto-1_1-x64.dll"
Delete "$INSTDIR\libssl-1_1-x64.dll"
Delete "$INSTDIR\Qt5Core.dll"
Delete "$INSTDIR\Qt5Gui.dll"
Delete "$INSTDIR\Qt5Network.dll"
Delete "$INSTDIR\Qt5Svg.dll"
Delete "$INSTDIR\Qt5Widgets.dll"
Delete "$INSTDIR\Qt5WinExtras.dll"
Delete "$INSTDIR\lang\gta5sync_en_US.qm"
Delete "$INSTDIR\lang\gta5sync_de.qm"
Delete "$INSTDIR\lang\gta5sync_fr.qm"
Delete "$INSTDIR\lang\gta5sync_ko.qm"
Delete "$INSTDIR\lang\gta5sync_ru.qm"
Delete "$INSTDIR\lang\gta5sync_uk.qm"
Delete "$INSTDIR\lang\gta5sync_zh_TW.qm"
Delete "$INSTDIR\lang\qtbase_en_GB.qm"
Delete "$INSTDIR\lang\qtbase_de.qm"
Delete "$INSTDIR\lang\qtbase_fr.qm"
Delete "$INSTDIR\lang\qtbase_ko.qm"
Delete "$INSTDIR\lang\qtbase_ru.qm"
Delete "$INSTDIR\lang\qtbase_uk.qm"
Delete "$INSTDIR\lang\qtbase_zh_TW.qm"
Delete "$INSTDIR\imageformats\qgif.dll"
Delete "$INSTDIR\imageformats\qicns.dll"
Delete "$INSTDIR\imageformats\qico.dll"
Delete "$INSTDIR\imageformats\qjpeg.dll"
Delete "$INSTDIR\imageformats\qsvg.dll"
Delete "$INSTDIR\imageformats\qtga.dll"
Delete "$INSTDIR\imageformats\qtiff.dll"
Delete "$INSTDIR\imageformats\qwbmp.dll"
Delete "$INSTDIR\imageformats\qwebp.dll"
Delete "$INSTDIR\platforms\qwindows.dll"
Delete "$INSTDIR\styles\qcleanlooksstyle.dll"
Delete "$INSTDIR\styles\qplastiquestyle.dll"
Delete "$INSTDIR\styles\qwindowsvistastyle.dll"
RmDir "$INSTDIR\lang"
RmDir "$INSTDIR\imageformats"
RmDir "$INSTDIR\platforms"
RmDir "$INSTDIR\styles"
 
Delete "$INSTDIR\uninstall.exe"
!ifdef WEB_SITE
Delete "$INSTDIR\${APP_NAME} website.url"
!endif

RmDir "$INSTDIR"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_GETFOLDER "Application" $SM_Folder
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\$SM_Folder\gta5view Website.lnk"
!endif
RmDir "$SMPROGRAMS\$SM_Folder"
!endif

!ifndef REG_START_MENU
Delete "$SMPROGRAMS\gta5view\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\gta5view\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\gta5view\gta5view Website.lnk"
!endif
RmDir "$SMPROGRAMS\gta5view"
!endif

DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}"
DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}"
SectionEnd

######################################################################

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
SetRegView 64
FunctionEnd

######################################################################
