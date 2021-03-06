module XMonad.Local.Log.XMobar ( myXMobarPP
                               , spawnXMobar
                               ) where

import XMonad
import XMonad.Hooks.DynamicLog ( PP (..)
                               , xmobarPP
                               )
import XMonad.Util.Run ( hPutStrLn
                       , spawnPipe
                       )

import Data.List ( intercalate
                 )
import GHC.IO.Handle ( Handle
                     )

import XMonad.Local.Config.Workspace ( Workspace
                                     )

spawnXMobar :: MonadIO m => m Handle
spawnXMobar = spawnPipe $ intercalate " " [ executable
                                          , flagIconroot
                                          , fileXMobarRc
                                          ]
    where executable = "xmobar"
          flagIconroot = "--iconroot=" <> xMobarConfigHome <> "/icons" -- can't be set with relative path in xmobarrc
          fileXMobarRc = xMobarConfigHome <> "/xmobarrc"
          xMobarConfigHome = "\"${XDG_CONFIG_HOME}\"/xmobar"

myXMobarPP :: Handle -> PP
myXMobarPP h = xmobarPP { ppOutput          = hPutStrLn h
                        , ppOrder           = \ (wss:_) -> [wss]
                        , ppWsSep           = ""
                        , ppCurrent         = clickableIcon "current"
                        , ppVisible         = clickableIcon "visible"
                        , ppUrgent          = clickableIcon "urgent"
                        , ppHidden          = clickableIcon "hidden"
                        , ppHiddenNoWindows = clickableIcon "hiddenNoWindows"
                        }

clickableIcon :: String -> WorkspaceId -> String
clickableIcon status wsId = let ws = read wsId :: Workspace
                                n = show $ 1 + fromEnum ws
                            in "<action=xdotool key super+" <> n <> ">" <>
                               "<icon=workspaces/" <> status <> "/workspace_" <> n <> ".xpm/>" <>
                               "</action>"
