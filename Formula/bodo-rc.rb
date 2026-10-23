# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4272-rc/bodo-darwin-arm64"
  version "2026.1023.4272-rc"
  sha256 "92f3907f3fc17ed8410a6d76df810b86a58b3ad7916a86c9b1383b973c5af4e8"
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
      url "https://cli.bodo-app.com/v/2026.1023.4272-rc/bodo-linux-arm64"
      sha256 "9210796472926112b71cc66c28203c7671f2176a9acb5e0dc57aebad262b0670"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4272-rc/bodo-linux-x64"
      sha256 "0f9b32364accaf4bbb56d2b60f0dabfc38e378cb80764d0a23fda1385c3dcca8"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
