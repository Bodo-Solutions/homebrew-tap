# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1005.3629-rc/bodo-darwin-arm64"
  version "2026.1005.3629-rc"
  sha256 "f1da6987a117cae24c683fd520fa15969b5a3fe3a60b95abf9f5a87f859eae33"
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
      url "https://cli.bodo-app.com/v/2026.1005.3629-rc/bodo-linux-arm64"
      sha256 "e02f1b272c774b8af15e56ee0e4d904b5d392fcae4c18ce96977444502899c8e"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1005.3629-rc/bodo-linux-x64"
      sha256 "bfbb8fb2d1a9713fe850b774715c185ac50e4f3f2ccd55dddceabf58119a344d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
