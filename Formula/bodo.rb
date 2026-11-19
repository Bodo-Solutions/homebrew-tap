# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1119.4754/bodo-darwin-arm64"
  version "2026.1119.4754"
  sha256 "6479d5ed3f3d55816699dfbf4d9815ce7b886a21db4d759696043a6e667df0b2"
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
      url "https://cli.bodo-app.com/v/2026.1119.4754/bodo-linux-arm64"
      sha256 "b768d0a2a34a21627ecb214f67be93dfb5ab4260d55d59680e3238ba59b96de2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1119.4754/bodo-linux-x64"
      sha256 "c3d10675eceb30c66ec116187cd405b01da6e79d4313b48aa36bfdd64d22cecb"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
