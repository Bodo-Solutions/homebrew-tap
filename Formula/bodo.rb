# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1010.3830/bodo-darwin-arm64"
  version "2026.1010.3830"
  sha256 "b030f3730effb9301fac51799ef9781666a04efcaaca0405c8f3215e29720b04"
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
      url "https://cli.bodo-app.com/v/2026.1010.3830/bodo-linux-arm64"
      sha256 "6de4b9d29fd7d4669ea3719eb0dddd9249bcb6fc09bf5fc2f2661a0225ecdf7b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1010.3830/bodo-linux-x64"
      sha256 "f8fb28b5c8c2f2ef46897b8e712cb68ad0a0f3f65de8d262bc7d400eba07226a"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
