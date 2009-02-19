import XMonad
import XMonad.Hooks.ManageDocks
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal      = "urxvtc"

myBorderWidth   = 0

myModMask       = mod4Mask

myNumlockMask   = mod2Mask

myWorkspaces    = ["1","2","3"]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask, 		xK_Return), spawn $ XMonad.terminal conf)

    -- launch firefox
    , ((modMask, 		xK_f     ), spawn "firefox")

    -- launch epdfview
    , ((modMask,		xK_e	 ), spawn "epdfview")

    -- launch abiword
    , ((modMask,		xK_b	 ), spawn "abiword")

    -- launch geanu
    , ((modMask,		xK_g	 ), spawn "geany")

    -- multimedia keys
    --
    -- XF86AudioMute
    , ((0,		  0x1008ff12	 ), spawn "amixer -q set PCM 0%")

    -- XF86AudioLowerVolume
    , ((0,		  0x1008ff11	 ), spawn "amixer -q set PCM 3dB-")

    -- XF86AudioRaiseVolume
    , ((0,		  0x1008ff13	 ), spawn "amixer -q set PCM 3dB+")

    -- XF86AudioPlay
    , ((0,		  0x1008ff14	 ), spawn "mpc toggle > /dev/null")

    -- XF86AudioStop
    , ((0,		  0x1008ff15	 ), spawn "mpc stop > /dev/null")

    -- XF86AudioPrev
    , ((0,		  0x1008ff16	 ), spawn "mpc prev > /dev/null")

    --XF86AudioNext
    , ((0,		  0x1008ff17	 ), spawn "mpc next > /dev/null")

    -- blank monitor
    , ((modMask,		xK_h	 ), spawn "xset dpms force off")

    -- lock screen
    , ((modMask,		xK_l	 ), spawn "slock")

    -- print screen
    , ((0,		      0xff61	 ), spawn "scrot")

    -- close focused window 
    , ((modMask, 		xK_k     ), kill)

    -- Move focus to the next window
    , ((modMask,               	xK_Tab   ), windows W.focusDown)

    -- Restart xmonad
    , ((modMask,  		xK_r     ), restart "xmonad" True)

    -- Quit xmonad
    , ((modMask, 		xK_q     ), io (exitWith ExitSuccess))
    ]
    ++

    --
    -- mod-[1..3], Switch to workspace N
    -- mod-shift-[1..3], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_3]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myLayout = avoidStruts Full


myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat ]

myStartupHook = return ()

main = xmonad defaults

defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,

      -- key bindings
        keys               = myKeys,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        startupHook        = myStartupHook
    }
