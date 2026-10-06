# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1006.3660-rc/bodo-darwin-arm64"
  version "2026.1006.3660-rc"
  sha256 "e515868da7ee682d94fff59690b14c5003cd1809201bf10e4731735f0c3c99cd"
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
      url "https://cli.bodo-app.com/v/2026.1006.3660-rc/bodo-linux-arm64"
      sha256 "9fcaeb53ea4161c3d93a67816d55c17ff89337510d1b8142bc26562a12bac57c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1006.3660-rc/bodo-linux-x64"
      sha256 "c8898416d4b4dbf70b02612c444fd05b00217df845f0e588f4d6e0a92bf15f35"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
