-- =====================================================================
--  Distortionz CalmAI Advanced - Server
--  This resource is entirely client-side (world AI is client-authoritative
--  in GTA). This file exists only to print the boot banner to the server
--  console alongside the rest of the Distortionz stack.
-- =====================================================================

CreateThread(function()
    Wait(1000)

    local modules = {}
    for name, enabled in pairs(Config.Modules) do
        if enabled then modules[#modules + 1] = name end
    end

    print(('^5[%s]^7 ^2v%s loaded — modules=%d radius=%.0fm^7'):format(
        GetCurrentResourceName(),
        Config.CurrentVersion,
        #modules,
        Config.Tuning.radius
    ))
end)
