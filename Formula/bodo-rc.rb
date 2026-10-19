# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1019.4098-rc/bodo-darwin-arm64"
  version "2026.1019.4098-rc"
  sha256 "df636a771b4abbb186224533f291020ee7c649268a66ca0035178926498a8c31"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1019.4098-rc/bodo-linux-arm64"
      sha256 "7b414da3093aa07469305c14f5fb2548cf061ed411ba937fc0922e9e7b7b3bf6"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1019.4098-rc/bodo-linux-x64"
      sha256 "189fb821eedb2ee9ba0656fd705584bcac80dfaadda8ca2b572767f3ab61599c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
