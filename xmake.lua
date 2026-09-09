set_xmakever("3.0.0")

-- Linux: MSVC via Wine. Windows: native MSVC (xmake default).
if is_host("linux") then
    includes("toolchains/msvc-wine.lua")
    add_repositories("skse-linux xmake-repo")
    set_policy("build.ccache", false)
    set_plat("windows")
    set_arch("x64")
    set_toolchains("msvc-wine")
end

includes("lib/commonlibsse-ng")

set_project("commonlibsse-ng-template")
set_version("0.0.0")
set_license("GPL-3.0")
set_languages("c++23")
set_warnings("allextra")

add_rules("mode.debug", "mode.releasedbg")
add_rules("plugin.vsxmake.autoupdate")
set_defaultmode("releasedbg")

if is_host("linux") then
    add_cxxflags("cl::/std:c++latest", {force = true})
    target("commonlibsse-ng")
        add_cxxflags("cl::/std:c++latest", {force = true})
    target_end()
end

set_policy("build.ccache", true)
set_policy("build.optimization.header_dependencies", false)

target("commonlibsse-ng-template")
    add_rules("commonlibsse-ng.plugin", {
        name = "commonlibsse-ng-template",
        author = "your name",
        description = "SKSE64 plugin template using CommonLibSSE-NG"
    })
    add_files("src/**.cpp")
    add_headerfiles("src/**.h")
    add_includedirs("src")
    set_pcxxheader("src/pch.h")
    -- The plugin rule runs `xmake install` after every rebuild. Without
    -- XSE_TES5_* that defaults to /usr/local or Program Files.
    on_config(function(target)
        if not os.getenv("XSE_TES5_MODS_PATH") and not os.getenv("XSE_TES5_GAME_PATH") then
            target:set("installdir", path.join(os.projectdir(), "build", "install"))
        end
    end)
target_end()
