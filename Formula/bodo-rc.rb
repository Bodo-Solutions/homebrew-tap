# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4314-rc/bodo-darwin-arm64"
  version "2026.1023.4314-rc"
  sha256 "75fad250f2b23a01ed5a340f7650490745468a386dac69c73e51cd120a322172"
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
      url "https://cli.bodo-app.com/v/2026.1023.4314-rc/bodo-linux-arm64"
      sha256 "a7f4ea4f2a7c5a178fe6a0e1fd264cf71926e0f96d1bab0012f35268c3421425"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4314-rc/bodo-linux-x64"
      sha256 "e1d844ef084ff3bc1127ffaa682ddec61e817d76939f0518d78c19fc3fba0855"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
