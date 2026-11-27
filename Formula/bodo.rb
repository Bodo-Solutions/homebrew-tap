# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1127.4768/bodo-darwin-arm64"
  version "2026.1127.4768"
  sha256 "3bada05715fe8a0fdfcab14b877b5b6cafb70f59bb3281956548194fc856873b"
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
      url "https://cli.bodo-app.com/v/2026.1127.4768/bodo-linux-arm64"
      sha256 "a88105110834ccd8d038b0045004ce11a6544dd538ad0eba9fc6029e1f18fa74"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1127.4768/bodo-linux-x64"
      sha256 "6c06bfba293e576fa87ef4a092a1667c5dd6736280c85b347637c104925262f7"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
