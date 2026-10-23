# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1023.4273-rc/bodo-darwin-arm64"
  version "2026.1023.4273-rc"
  sha256 "724fdd0389f720f5ea3d08e737ea22f94442f3ddc3d705507bb8944c62015f0b"
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
      url "https://cli.bodo-app.com/v/2026.1023.4273-rc/bodo-linux-arm64"
      sha256 "eb334066ec33beadfe7c251422eaa61b1bece73cc884269d1409944bdb8cb33a"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1023.4273-rc/bodo-linux-x64"
      sha256 "d29b6b935b538e84e6f4329320277417e0b68518bab4df35bb58f42c82cf1c4d"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
