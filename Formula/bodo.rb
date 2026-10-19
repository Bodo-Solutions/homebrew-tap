# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4101/bodo-darwin-arm64"
  version "2026.1019.4101"
  sha256 "d499654c5ba249e656bc6a6376571efcea47b28a4b818308fe0b16cc9c9ba1c5"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1019.4101/bodo-linux-arm64"
      sha256 "b9b1858a71db29ab2f972d1fe15a955c474c13fff8913689b0a3fb45b8793173"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4101/bodo-linux-x64"
      sha256 "2b746be0bde0b624e6a51756e688d621d6d75ceec3bc9cd88c9521ee41e6e64e"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
