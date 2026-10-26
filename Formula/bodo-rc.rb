# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1026.4438-rc/bodo-darwin-arm64"
  version "2026.1026.4438-rc"
  sha256 "6c161df32c98b9ee3f47cd683a2a5620bba6525d5d489b82f55e36708531d087"
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
      url "https://cli.bodo-app.com/v/2026.1026.4438-rc/bodo-linux-arm64"
      sha256 "5ec85b47f959394f56b264743998b5250f8d732b37deecd9d9e5222365e4c5f4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1026.4438-rc/bodo-linux-x64"
      sha256 "f0461806963eabfd5a4505aaf712e93165fcd8e8cbd6944f12d0f4a6c2837538"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
