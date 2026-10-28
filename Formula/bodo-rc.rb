# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4532-rc/bodo-darwin-arm64"
  version "2026.1028.4532-rc"
  sha256 "4a114c8ddd4f6f82377859cd50b5e9fca58a941455e41f4bd2bb8a8b633f7abe"
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
      url "https://cli.bodo-app.com/v/2026.1028.4532-rc/bodo-linux-arm64"
      sha256 "b2a02ae7d5ea84d2387cf11c0d8ce8a225fed62c34eff4f8b09104b39d5623f3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4532-rc/bodo-linux-x64"
      sha256 "3b419f11915a889112f5cd359a6db8cbfaf69636101cfa58a862b9fcc325bd67"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
