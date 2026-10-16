# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1016.3992-rc/bodo-darwin-arm64"
  version "2026.1016.3992-rc"
  sha256 "c0e68fde243c27791103e0b4bcc6f90e1c2768413465097ed834cc6b382bc621"
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
      url "https://cli.bodo-app.com/v/2026.1016.3992-rc/bodo-linux-arm64"
      sha256 "318beb9686443f560e5d5bf92ae470b24bb8c0a1bbdee635edf5b6b80260cf9d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1016.3992-rc/bodo-linux-x64"
      sha256 "bfb8a062c47038a99aacc70cc50f14e7f6511d57ecbee913a3c3ecc47c4ca79d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
